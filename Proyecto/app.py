from flask import Flask, render_template, request, redirect, url_for, flash, session
from main import GestorTareas
import bcrypt

app = Flask(__name__)
app.config['SECRET_KEY'] = '20_cosas_que_no_sabias_de_las_empanadas'

gestor = GestorTareas()


@app.route("/")
def index():
    return render_template("inicio.html")


@app.route("/iniciosesion")
def iniciosesion():
    return render_template("iniciosesion.html")


@app.route('/validaSesion', methods=['POST'])
def validasesion():

    email = request.form.get('email', '').strip()
    password = request.form.get('password', '').strip()

    if not email or not password:
        flash('Todos los campos son obligatorios', 'error')
        return render_template('iniciosesion.html')

    usuario = gestor.usuarios.find_one({"email": email})

    if not usuario:
        flash('Usuario no registrado', 'error')
        return render_template('iniciosesion.html')

    if not bcrypt.checkpw(password.encode('utf-8'), usuario['password']):
        flash('Contraseña incorrecta', 'error')
        return render_template('iniciosesion.html')

    session['usuario'] = usuario['nombre']
    session['usuario_email'] = usuario['email']
    session['logueado'] = True

    return redirect(url_for('interfaz'))


@app.route("/gestor")
def gestor_view():
    return render_template("gestordetareas.html")


@app.route("/creacuenta")
def crearcuenta():
    return render_template("crearcuenta.html")


@app.route('/registrame', methods=['POST'])
def registrame():

    nombre = request.form.get("nombre", "").strip()
    apellido = request.form.get("apellidos", "").strip()
    email = request.form.get("email", "").strip()
    password = request.form.get("password", "").strip()

    if not nombre or not apellido or not email or not password:
        flash("Todos los campos son obligatorios", "error")
        return render_template("crearcuenta.html")

    if len(password) < 8:
        flash("La contraseña debe tener al menos 8 caracteres", "error")
        return render_template("crearcuenta.html")

    if gestor.usuarios.find_one({"email": email}):
        flash("Este correo ya está registrado", "error")
        return render_template("crearcuenta.html")

    password_bytes = password.encode('utf-8')
    hashed = bcrypt.hashpw(password_bytes, bcrypt.gensalt())

    gestor.usuarios.insert_one({
        "nombre": f"{nombre} {apellido}",
        "email": email,
        "password": hashed
    })

    flash("Cuenta creada correctamente")
    return redirect(url_for("interfaz"))


@app.route("/interfaz")
def interfaz():
    if not session.get('logueado'):
        return redirect(url_for('iniciosesion')
)
    return render_template("interfazinicio.html")


if __name__ == "__main__":
    app.run(debug=True)

from flask import Flask, render_template, request, redirect, url_for, flash, session
from main import GestorTareas
import bcrypt

app = Flask(__name__)
app.config['SECRET_KEY'] = '20_cosas_que_no_sabias_de_las_empanadas'

# Conexión a Mongo
gestor = GestorTareas()


@app.route("/")
def index():
    return render_template("inicio.html")


@app.route("/iniciosesion")
def iniciosesion():
    return render_template("iniciosesion.html")


# 🔵 LOGIN
@app.route('/validaSesion', methods=['POST'])
def validasesion():

    email = request.form.get('email', '').strip()
    password = request.form.get('password', '').strip()

    # Validación de campos
    if not email or not password:
        flash('Todos los campos son obligatorios', 'error')
        return render_template('iniciosesion.html')

    # Buscar usuario en Mongo
    usuario = gestor.usuarios.find_one({"email": email})

    if not usuario:
        flash('Usuario no registrado', 'error')
        return render_template('iniciosesion.html')

    # Verificar contraseña con bcrypt
    if not bcrypt.checkpw(password.encode('utf-8'), usuario['password']):
        flash('Contraseña incorrecta', 'error')
        return render_template('iniciosesion.html')

    # Si todo está bien → login correcto
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


# 🟢 REGISTRO
@app.route('/registrame', methods=['POST'])
def registrame():

    nombre = request.form.get("nombre", "").strip()
    apellido = request.form.get("apellidos", "").strip()
    email = request.form.get("email", "").strip()
    password = request.form.get("password", "").strip()

    # Validación de campos
    if not nombre or not apellido or not email or not password:
        flash("Todos los campos son obligatorios", "error")
        return render_template("crearcuenta.html")

    # Validación básica de contraseña
    if len(password) < 8:
        flash("La contraseña debe tener al menos 8 caracteres", "error")
        return render_template("crearcuenta.html")

    # Verificar si ya existe
    if gestor.usuarios.find_one({"email": email}):
        flash("Este correo ya está registrado", "error")
        return render_template("crearcuenta.html")

    # 🔐 Encriptar contraseña (hashing)
    password_bytes = password.encode('utf-8')
    hashed = bcrypt.hashpw(password_bytes, bcrypt.gensalt())

    # Guardar en Mongo
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
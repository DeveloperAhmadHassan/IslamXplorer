from flask import Flask, request, redirect, url_for

app = Flask(__name__)

sentence = "Hello World\nThis is my first Flask Application"


@app.route('/success/<name>')
def success(name):
    return 'welcome %s' % name


# ‘/’ URL is bound with hello_world() function.
@app.route('/login', methods=['POST', 'GET'])
def login():
    if request.method == 'POST':
        user = request.form['nm']
        return redirect(url_for('success', name='POST '+user))
    else:
        user = request.args.get('nm')
        return redirect(url_for('success', name='GET '+user))


# main driver function
if __name__ == '__main__':
    app.run()

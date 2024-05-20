const { Login } = require("backend/controllers/auth_controller.js");

describe('Test Handlers', function () {

    test('responds to /:email/:password', () => {
        const req = { params: { email: 'fatayerjiaseel@gmail.com', password: '123e456y' } };

        const res = {
            text: '',
            send: function (input) { this.text = input }
        };
        Login(req, res);

    });


});
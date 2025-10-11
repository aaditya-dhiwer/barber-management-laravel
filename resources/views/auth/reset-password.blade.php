<!DOCTYPE html>
<html>
<head>
    <title>Reset Password</title>
</head>
<body>
    <h2>Reset Your Password</h2>

    <form method="POST" action="{{ route('reset.password.submit') }}">
        @csrf
        <input type="hidden" name="token" value="{{ request('token') }}">
        <input type="hidden" name="email" value="{{ request('email') }}">

        <div>
            <label>New Password</label>
            <input type="password" name="password" required>
        </div>

        <div>
            <label>Confirm Password</label>
            <input type="password" name="password_confirmation" required>
        </div>

        <button type="submit">Reset Password</button>
    </form>
</body>
</html>

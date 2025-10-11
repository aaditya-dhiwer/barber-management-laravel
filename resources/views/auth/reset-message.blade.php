<!DOCTYPE html>
<html>

<head>
    <title>Password Reset Status</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>

<body class="bg-light d-flex justify-content-center align-items-center" style="height: 100vh;">

    <div class="text-center">
        @if ($type === 'success')
            <div class="alert alert-success p-4 shadow">
                <h4>{{ $message }}</h4>
            </div>
        @else
            <div class="alert alert-danger p-4 shadow">
                <h4>{{ $message }}</h4>
            </div>
        @endif
    </div>

</body>

</html>

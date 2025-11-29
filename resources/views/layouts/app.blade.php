<!DOCTYPE html>
<html>

<head>
    <title>Shop Management</title>
</head>

<body>

    {{-- Success Message --}}
    @if (session('success'))
        <p style="color: green; padding:10px;">{{ session('success') }}</p>
    @endif

    {{-- Main Content --}}
    <div>
        @yield('content')
    </div>

</body>

</html>

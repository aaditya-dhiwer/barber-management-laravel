<!DOCTYPE html>
<html>

<head>
    <title>Shop Details</title>
</head>

<body>

    <div style="width: 90%; margin: 20px auto;">
        <h2>Shop Details Page</h2>
        <a href="{{ route('shops.index') }}">← Back to List</a>
        <hr><br>

        {{-- 1️⃣ Shop Owner Info --}}
        <h3>Shop Owner Information</h3>
        <table border="1" cellpadding="8" cellspacing="0" width="100%">
            <tr>
                <th>Name</th>
                <td>{{ $owner->name ?? 'N/A' }}</td>
            </tr>
            <tr>
                <th>Email</th>
                <td>{{ $owner->email ?? 'N/A' }}</td>
            </tr>
            <tr>
                <th>Phone</th>
                <td>{{ $owner->phone ?? 'N/A' }}</td>
            </tr>
        </table>

        <br>

        {{-- 2️⃣ Shop Details --}}
        <h3>Shop Details</h3>
        @if ($shop->profile_image)
            <div style="margin-bottom: 20px; align-items: center; display: flex; justify-content: center;">
                <h3>Shop Image</h3>
                <img src="{{ asset('storage/' . $shop->profile_image) }}" alt="Shop Image"
                    style="max-width: 300px; border:1px solid #ccc; padding:5px; border-radius:4px;">
            </div>
        @else
            <p><i>No Image Available</i></p>
        @endif

        <table border="1" cellpadding="8" cellspacing="0" width="100%">
            <tr>
                <th>Shop Name</th>
                <td>{{ $shop->name }}</td>
            </tr>
            <tr>
                <th>State</th>
                <td>{{ $shop->state }}</td>
            </tr>
            <tr>
                <th>City</th>
                <td>{{ $shop->city }}</td>
            </tr>
            <tr>
                <th>Pincode</th>
                <td>{{ $shop->postal_code }}</td>
            </tr>
            <tr>
                <th>Address</th>
                <td>{{ $shop->address }}</td>
            </tr>

            <tr>
                <th>Current Step</th>
                <td>{{ $shop->current_step }}</td>
            </tr>
        </table>

        <br>

        {{-- 3️⃣ Services List --}}
        <h3>Services Offered</h3>
        @if (count($services) > 0)
            <table border="1" cellpadding="8" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Service Name</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($services as $service)
                        <tr>
                            <td>{{ $loop->iteration }}</td>
                            <td>{{ $service->name }}</td>
                            <td>{{ $service->price }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        @else
            <p>No services added.</p>
        @endif

        <br>

        {{-- 4️⃣ Workers Details --}}
        <h3>Workers Information</h3>
        @if (count($workers) > 0)
            <table border="1" cellpadding="8" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>Worker Name</th>
                        <th>Role</th>
                        <th>Phone</th>
                    </tr>
                </thead>
                <tbody>
                    @foreach ($workers as $worker)
                        <tr>
                            <td>{{ $loop->iteration }}</td>
                            <td>{{ $worker->name }}</td>
                            <td>{{ $worker->role }}</td>
                            <td>{{ $worker->phone }}</td>
                        </tr>
                    @endforeach
                </tbody>
            </table>
        @else
            <p>No workers added.</p>
        @endif

    </div>

</body>

</html>

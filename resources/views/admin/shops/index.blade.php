<!DOCTYPE html>
<html>

<head>
    <title>Shop Management</title>
</head>

<body>

    <div style="width: 90%; margin: 20px auto;">

        <h2>Shop List</h2>

        {{-- Success Message --}}
        @if (session('success'))
            <p style="color: green;">{{ session('success') }}</p>
        @endif

        {{-- Filter Dropdown --}}
        <form method="GET" action="{{ route('shops.index') }}" style="margin-bottom:10px;">
            <label for="filter"><b>Filter by Status:</b></label>
            <select name="filter" id="filter" onchange="this.form.submit()">
                <option value="all">All</option>
                @foreach ($statusLabels as $key => $value)
                    <option value="{{ $key }}" {{ request('filter') == $key ? 'selected' : '' }}>
                        {{ $value }}
                    </option>
                @endforeach
            </select>
        </form>

        {{-- Table --}}
        <table border="1" cellpadding="8" cellspacing="0" width="100%">
            <thead>
                <tr>
                    <th>#</th>
                    <th>Shop Name</th>
                    {{-- <th>Email</th> --}}
                    <th>Current Step</th>
                    {{-- <th>View Details</th> --}}
                    <th>Action</th>
                </tr>
            </thead>
            <tbody>
                @foreach ($shops as $shop)
                    <tr @if ($shop->current_step == 4) style="background-color: #fff3cd;" @endif>
                        <td>{{ $loop->iteration }}</td>
                        <td>{{ $shop->name }}</td>
                        {{-- <td>{{ $shop->email }}</td> --}}
                        <td>
                            {{ $statusLabels[$shop->current_step] ?? '-' }}
                        </td>
                        <td>
                            <button onclick="openModal({{ $shop->id }})">Update</button>
                            <a href="{{ route('shops.show', $shop->id) }}" style="margin-left:5px;">
                                <button>Details</button>
                            </a>
                        </td>

                        {{-- <td>
                            <button onclick="openModal({{ $shop->id }})">Update</button>
                        </td> --}}
                    </tr>
                @endforeach
            </tbody>
        </table>

        {{-- Modal --}}
        <div id="popupModal"
            style="display:none; position:fixed; top:0; left:0; width:100%; height:100%;
         background:rgba(0,0,0,0.5); text-align:center;">
            <div style="margin:10% auto; background:white; padding:20px; width:300px;">
                <h3>Update Status</h3>
                <form id="statusForm" method="POST">
                    @csrf
                    <button name="status" value="approve">Approve</button>
                    <button name="status" value="decline">Decline</button>
                </form>
                <br>
                <button onclick="closeModal()">Cancel</button>
            </div>
        </div>

    </div>

    <script>
        function openModal(shopId) {
            document.getElementById('popupModal').style.display = 'block';
            document.getElementById('statusForm').action = `/admin/shops/${shopId}/update-status`;
        }

        function closeModal() {
            document.getElementById('popupModal').style.display = 'none';
        }
    </script>

</body>

</html>

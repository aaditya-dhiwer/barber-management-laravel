@extends('layouts.app')

@section('content')
    <div class="container">
        <h2>All Owners Details</h2>

        @foreach ($owners as $owner)
            <div class="card mb-4 p-3 border">
                <h4>Owner: {{ $owner->name }} ({{ $owner->email }})</h4>

                {{-- Owner Images --}}
                @if ($owner->images)
                    <div class="d-flex gap-2 mb-2">
                        @foreach ($owner->images as $img)
                            <img src="{{ asset('storage/' . $img->path) }}" width="80" class="rounded">
                        @endforeach
                    </div>
                @endif

                {{-- Shop Details --}}
                @foreach ($owner->shops as $shop)
                    <div class="border mt-3 p-3 rounded bg-light">
                        <h5>Shop: {{ $shop->name }}</h5>
                        <p>Address: {{ $shop->address }}</p>
                        <p>Status Step: {{ $shop->current_step }}</p>

                        {{-- Shop Images --}}
                        @if ($shop->images)
                            <div class="d-flex gap-2 mb-2">
                                @foreach ($shop->images as $img)
                                    <img src="{{ asset('storage/' . $img->path) }}" width="80" class="rounded">
                                @endforeach
                            </div>
                        @endif

                        {{-- Services --}}
                        <h6>Services:</h6>
                        <ul>
                            @foreach ($shop->services as $service)
                                <li>{{ $service->service->name }} - ₹{{ $service->service->price }}</li>
                            @endforeach
                        </ul>

                        {{-- Members --}}
                        <h6>Members:</h6>
                        <ul>
                            @foreach ($shop->members as $member)
                                <li>{{ $member->user->name }} ({{ $member->user->email }})</li>
                            @endforeach
                        </ul>

                        {{-- Approve / Decline Buttons --}}
                        <form method="POST" action="{{ route('shop.approve', $shop->id) }}" class="d-inline">
                            @csrf
                            <button class="btn btn-success btn-sm">Approve</button>
                        </form>

                        <form method="POST" action="{{ route('shop.decline', $shop->id) }}" class="d-inline">
                            @csrf
                            <button class="btn btn-danger btn-sm">Decline</button>
                        </form>

                    </div>
                @endforeach
            </div>
        @endforeach
    </div>
@endsection

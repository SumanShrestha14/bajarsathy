@extends('dashboard')

@section('title', 'Today\'s Prices')

@section('content')

@if(session('success'))
    <div class="bg-green-100 text-green-700 p-2 mb-4 rounded">
        {{ session('success') }}
    </div>
@endif

<table class="min-w-full bg-white border">
    <thead>
        <tr>
            <th class="border px-4 py-2">ID</th>
            <th class="border px-4 py-2">Product Name</th>
            <th class="border px-4 py-2">Unit</th>
            <th class="border px-4 py-2">Min Price</th>
            <th class="border px-4 py-2">Max Price</th>
            <th class="border px-4 py-2">Avg Price</th>
            <th class="border px-4 py-2">Product Image</th>
            <th class="border px-4 py-2">Update Image</th>
        </tr>
    </thead>
    <tbody>
        @foreach($prices as $price)
            <tr>
                <td class="border px-4 py-2">{{ $price->id }}</td>
                <td class="border px-4 py-2">{{ $price->product_name }}</td>
                <td class="border px-4 py-2">{{ $price->unit }}</td>
                <td class="border px-4 py-2">{{ $price->min_price }}</td>
                <td class="border px-4 py-2">{{ $price->max_price }}</td>
                <td class="border px-4 py-2">{{ $price->avg_price }}</td>
                <td class="border px-4 py-2">
                    @if($price->product_image)
                        <img src="{{ asset('uploads/products/' . $price->product_image) }}" class="w-16 h-16 object-cover rounded">
                    @else
                        N/A
                    @endif
                </td>
                <td class="border px-4 py-2">
                    <form action="{{ route('prices.updateImage', $price->id) }}" method="POST" enctype="multipart/form-data">
                        @csrf
                        @method('PUT')
                        <input type="file" name="product_image" class="border p-1 mb-1 w-full">
                        <button type="submit" class="bg-blue-600 text-white px-3 py-1 rounded w-full">
                            Update
                        </button>
                    </form>
                </td>
            </tr>
        @endforeach
    </tbody>
</table>

@endsection

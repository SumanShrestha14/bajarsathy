<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class PriceModel extends Model
{
    use HasFactory;

    protected $table = 'prices';

    protected $fillable = [
        'product_name',
        'unit',
        'min_price',
        'max_price',
        'avg_price',
    ];
}

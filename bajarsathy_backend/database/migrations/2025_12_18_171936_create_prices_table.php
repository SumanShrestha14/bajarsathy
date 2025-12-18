<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    public function up(): void
    {
        Schema::create('prices', function (Blueprint $table) {
            $table->id();
            $table->string('product_name');            // Name of the crop
            $table->string('unit')->nullable();        // e.g., के.जी., दर्जन, प्रति गोटा
            $table->decimal('min_price', 10, 2)->nullable(); // न्यूनतम
            $table->decimal('max_price', 10, 2)->nullable(); // अधिकतम
            $table->decimal('avg_price', 10, 2)->nullable(); // औसत
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('prices');
    }
};

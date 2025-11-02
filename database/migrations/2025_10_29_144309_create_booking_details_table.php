<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        Schema::create('booking_details', function (Blueprint $table) {
            $table->id();
            $table->foreignId('booking_id')->constrained('bookings')->onDelete('cascade');
            $table->foreignId('service_id')->constrained('shop_services')->onDelete('restrict');

            // Service Specific Details (in case prices/durations change later)
            $table->unsignedDecimal('price_at_booking', 8, 2);
            $table->unsignedSmallInteger('duration_minutes');



            // Compound unique index to prevent duplicate service additions
            $table->unique(['booking_id', 'service_id']);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('booking_details');
    }
};

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
        Schema::create('bookings', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shop_id')->constrained()->onDelete('cascade');
            $table->foreignId('shop_member_id')->nullable()->constrained('shop_members')->onDelete('set null');
            $table->foreignId('customer_id')->constrained('users')->onDelete('cascade');
            // $table->foreignId('service_id')->constrained('shop_services')->onDelete('cascade');
            $table->date('date');
            $table->time('start_time');
            $table->time('end_calculated_time')->nullable();
            $table->integer('total_duration')->nullable();
            $table->decimal('total_price', 8, 2);
            $table->enum('status', ['pending', 'confirmed', 'cancelled', "cancelled_by_owner", "completed", "cancelled_by_customer", "customer_not_arrived"])->default('pending');
            $table->text('notes')->nullable();
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::disableForeignKeyConstraints();
        // Schema::dropIfExists('bookings');
        // Schema::enableForeignKeyConstraints();

        Schema::dropIfExists('bookings');
    }
};

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
        Schema::create('shop_services', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shop_id')->constrained()->onDelete('cascade');
            $table->foreignId('category_id')->constrained('service_categories')->onDelete('cascade');
            $table->string('name');
            $table->decimal('price', 8, 2);
            $table->integer('duration');

            $table->decimal('product_cost', 8, 2)->nullable();
            $table->decimal('special_price', 8, 2)->nullable();
            $table->enum('gender', ['male',    'female',])->default('male');
            $table->text('description')->nullable();
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        Schema::dropIfExists('shop_services');
    }
};

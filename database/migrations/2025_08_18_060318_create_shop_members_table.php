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
        Schema::create('shop_members', function (Blueprint $table) {
            $table->id();
            $table->foreignId('shop_id')->constrained()->onDelete('cascade');
            $table->string('name');
            $table->string('profile_image')->nullable();
            $table->string('specialty')->nullable();
            $table->string('phone')->nullable();
            $table->text("bio")->nullable();
            $table->enum("role", ['owner', 'staff', 'manager'])->default('staff');
            $table->date("dob")->nullable(); // Date of Birth
            $table->boolean("receive_sms_promotions")->default(true);
            $table->boolean("receive_email_promotions")->default(true);
            $table->boolean('is_active')->default(true);
            $table->timestamps();
        });
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // Schema::disableForeignKeyConstraints();
        // Schema::dropIfExists('shop_members');
        // Schema::enableForeignKeyConstraints();
        Schema::dropIfExists('shop_members');
    }
};

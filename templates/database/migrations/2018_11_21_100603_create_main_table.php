<?php
/** @noinspection PhpIllegalPsrClassPathInspection */
declare(strict_types = 1);

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

/**
 * TODO: Missing class description.
 */
class CreateMainTable extends Migration
{
    
    /**
     * Run the migrations.
     */
    public function up() : void
    {
        Schema::create(
            'some_table',
            static function (Blueprint $table) {
                $table->bigIncrements('id');
                $table->dateTimeTz('created_at');
                $table->dateTimeTz('updated_at');
            }
        );
    }
    
    /**
     * Reverse the migrations.
     */
    public function down() : void
    {
        Schema::dropIfExists('some_table');
    }
}

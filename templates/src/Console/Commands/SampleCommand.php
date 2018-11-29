<?php
declare(strict_types = 1);


namespace SmartWeb\Webhooks\Console\Commands;

use Illuminate\Console\Command;
use Illuminate\Database\DatabaseManager;

/**
 * TODO: Missing class description.
 *
 * @author Nicolai Agersbæk <na@smartweb.dk>
 */
class SampleCommand extends Command
{
    
    /**
     * @inheritDoc
     */
    protected $name = 'test:woo';
    
    /**
     * @inheritDoc
     */
    protected $description = 'Testing some woo!';
    
    /**
     * @var DatabaseManager
     */
    private $db;
    
    /**
     * @param DatabaseManager $db
     */
    public function __construct(DatabaseManager $db)
    {
        parent::__construct();
        
        $this->db = $db;
    }
    
    /**
     * Execute the console command.
     *
     * @return int|null
     */
    public function handle() : ?int
    {
        $this->getOutput()->comment('connecting to database...');
        
        $this->getOutput()->comment($this->db->connection()->getDatabaseName());
        
        $config = \config('queue', []);
        $this->getOutput()->comment(\var_export($config, true));
        
        return 0;
    }
}

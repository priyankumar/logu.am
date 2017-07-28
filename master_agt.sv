class master_agt extends uvm_agent;
`uvm_component_utils(master_agt)

master_dvr master_dvr_h;
master_mon master_mon_h;
master_sequencer master_sequencer_h;
master_cfg master_cfg_h;
extern function new(string name="master_agt",uvm_component parent);
extern function void build_phase(uvm_phase phase);
extern function void connect_phase(uvm_phase phase);
endclass

function master_agt::new(string name="master_agt",uvm_component parent);
super.new(name,parent);
endfunction

function void master_agt::build_phase(uvm_phase phase);
super.build_phase(phase);


if(!uvm_config_db #(master_cfg)::get(this,"","master_cfg_ptr",master_cfg_h))
`uvm_fatal("master_agt","getting failed")
//creating monitor
master_mon_h=master_mon::type_id::create("master_mon_h",this);
//creating dvr &sequencer
if(master_cfg_h.is_active)
begin
master_dvr_h=master_dvr::type_id::create("master_dvr_h",this);
master_sequencer_h=master_sequencer::type_id::create("master_sequencer_h",this);
end


endfunction


function void master_agt::connect_phase(uvm_phase phase);
super.connect_phase(phase);
master_dvr_h.seq_item_port.connect(master_sequencer_h.seq_item_export);
endfunction

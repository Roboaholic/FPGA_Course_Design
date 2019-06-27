library verilog;
use verilog.vl_types.all;
entity smg_interface is
    port(
        CLK             : in     vl_logic;
        RSTn            : in     vl_logic;
        Number_Sig      : in     vl_logic_vector(23 downto 0);
        SMG_Data        : out    vl_logic_vector(7 downto 0);
        Scan_Sig        : out    vl_logic_vector(5 downto 0)
    );
end smg_interface;

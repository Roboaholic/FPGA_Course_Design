library verilog;
use verilog.vl_types.all;
entity smg_scan_module is
    generic(
        T1MS            : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        CLK             : in     vl_logic;
        RSTn            : in     vl_logic;
        Scan_Sig        : out    vl_logic_vector(5 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T1MS : constant is 1;
end smg_scan_module;

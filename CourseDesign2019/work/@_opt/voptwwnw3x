library verilog;
use verilog.vl_types.all;
entity smg_control_module is
    generic(
        T1MS            : vl_logic_vector(0 to 15) := (Hi1, Hi1, Hi0, Hi0, Hi0, Hi0, Hi1, Hi1, Hi0, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        CLK             : in     vl_logic;
        RSTn            : in     vl_logic;
        Number_Sig      : in     vl_logic_vector(23 downto 0);
        Number_Data     : out    vl_logic_vector(3 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T1MS : constant is 1;
end smg_control_module;

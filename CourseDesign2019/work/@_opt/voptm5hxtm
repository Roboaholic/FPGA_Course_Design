library verilog;
use verilog.vl_types.all;
entity Timer is
    generic(
        T100MS          : vl_logic_vector(0 to 22) := (Hi1, Hi0, Hi0, Hi1, Hi1, Hi0, Hi0, Hi0, Hi1, Hi0, Hi0, Hi1, Hi0, Hi1, Hi1, Hi0, Hi0, Hi1, Hi1, Hi1, Hi1, Hi1, Hi1)
    );
    port(
        CLK             : in     vl_logic;
        RSTn            : in     vl_logic;
        Number_Sig      : out    vl_logic_vector(23 downto 0)
    );
    attribute mti_svvh_generic_type : integer;
    attribute mti_svvh_generic_type of T100MS : constant is 1;
end Timer;

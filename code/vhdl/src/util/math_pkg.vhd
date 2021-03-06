library ieee;
  use ieee.fixed_pkg.all;

package math_pkg is
  function log2(x : integer) return integer;
  function max(l, r : sfixed) return sfixed;
end math_pkg;

package body math_pkg is
  -- compute the binary logarithm
  function log2(x : integer) return integer is
    variable i : integer := 0;
  begin
    if x = 0 then
      return 0;
    else
      while 2**i < x loop
        i := i + 1;
      end loop;
      return i;
    end if;
  end function log2;

  -- obtain the maximum of two signed fixed point numbers
  function max(l, r : sfixed) return sfixed is
  begin
    if l > r then
      return l;
    else
      return r;
    end if;
  end max;
end math_pkg;
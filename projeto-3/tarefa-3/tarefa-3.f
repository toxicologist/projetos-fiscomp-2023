      implicit real*8 (a-h,o-z)

      end

      function cf(x)
         real*8 cf,x
         cf = x**3d0 - 4d0*(x**2d0) - 59d0*x + 126d0
      end function

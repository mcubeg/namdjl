"""

In this example, the distance between the C-terminal carbon
and a sodium atom is computed and ploted as a function of time

"""

push!(LOAD_PATH,"../src")

using Namd

println(" Loading Plots... ")
using Plots

function main()

  # Initialize simulation data and path to VMD executable
  println(" Reading simulation data ... ")
  Namd.init(psf="./structure.psf",
            dcd="./structure.dcd",
            vmd="vmd")

  println(" Defining selections... ")
  cterm = Namd.select("protein and resid 253 and name C")
  sod = Namd.select("index 20455")

  # Vector that will contain the distances for each frame
  d = Vector{Float64}(undef,Namd.nframes)

  println(" Computing distances ... ")
  for i in 1:Namd.nframes
    sides, x, y, z = Namd.nextframe()

    # Wrap coordinates of the sodium around cterm

    x_cterm = [ x[cterm[1]], y[cterm[1]], z[cterm[1]] ]
    Namd.wrap!(sides,x,y,z;center=x_cterm,sel=sod)

    # Compute distance

    d[i] = sqrt( ( x[cterm[1]] - x[sod[1]] )^2 + 
                 ( y[cterm[1]] - y[sod[1]] )^2 + 
                 ( z[cterm[1]] - z[sod[1]] )^2 ) 

  end
  Namd.closedcd()

  println(" Plotting... ")

  x = [ i for i in 1:Namd.nframes ]
  plot(x,d)
  savefig("example2.pdf")

end; main()





module PDB

  using Printf

  function printatom(index,name,resname,chain,residue,x,y,z;
                     occup=0.,beta=0.,segname=nothing,type=nothing)

    if segname == nothing && type == nothing
      line = @sprintf("%-6s%5i%4s %4s %1s%4i    %8.3f%8.3f%8.3f%6.2f%6.2f", 
                      "ATOM",index,name,resname,chain,residue,x,y,z,occup,beta)
    end
    #elseif segname != nothing
    #  line = $(@sprintf(pdbformat, "ATOM",index,name,resname,chain,residue,x,y,z,occup,beta,segname))"
    #elseif type != nothing
    #  line $(@sprintf(pdbformat, "ATOM",index,name,resname,chain,residue,x,y,z,occup,beta,type))"
    #else
    #  line $(@sprintf(pdbformat, "ATOM",index,name,resname,chain,residue,x,y,z,occup,beta,segname,type))"
    #end

    return line
  end

end





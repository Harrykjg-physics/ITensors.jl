using ITensors,
      Random,
      Test

Random.seed!(12345)

include("2d_classical_ising.jl")
include("trg.jl")

@testset "trg" begin
  # Make Ising model MPO
  β = 1.1*βc
  d = 2
  s = Index(d)
  l = tags(s," -> left")
  r = tags(s," -> right")
  u = tags(s," -> up")
  d = tags(s," -> down")
  T = ising_mpo((l,r),(u,d),β)

  χmax = 20
  nsteps = 20
  κ,T = trg(T;χmax=χmax,nsteps=nsteps)

  @test κ≈exp(-β*ising_free_energy(β)) atol=1e-4
end


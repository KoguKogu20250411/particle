using particle
import particle: timeprop
using Test

@testset "particle.jl" begin
    # 等速度運動のテスト
    @testset "Test motion" begin
        # 設定
        F(x, t) = 0.0
        tmax = 1.0
        x_0 = 0.0
        a_0 = 1.0  # 初速度
        h = 1e-4  # 時間幅

        x_f, a_f = timeprop(F, tmax, x_0, a_0, h)
        
        # 理論値
        x_e = x_0 + a_0 * tmax
        a_e = a_0  # 加速度は一定なので変化しない

        @test isapprox(x_f, x_e, rtol=1e-10)
        @test isapprox(a_f, a_e, rtol=1e-10)
    end


end 

nothing # test実行時に標準出力に大量のメッセージが出ないようにするおまじない
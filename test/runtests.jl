using particle
import particle: timeprop
using Test

@testset "particle.jl" begin
    #等速度運動のテスト
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
        # 等加速度運動のテスト
    @testset "Uniform acceleration motion" begin
        # 加速度が一定の等加速度運動
        F(x, t) = 1.0  # 一定の加速度
        tmax = 1.0
        x_0 = 0.0
        a_0 = 0.0  # 初期速度
        h = 1e-4   # 時間ステップ

        x_final, a_final = timeprop(F, tmax, x_0, a_0, h)
        
        # 理論値: x = x_0 + v_0*t + (1/2)*a*t^2
        # 理論値: v = v_0 + a*t
        expected_x = x_0 + a_0 * tmax + 0.50 * tmax^2
        expected_a = a_0 +  tmax

        @test isapprox(x_final, expected_x, rtol=1e-3)
        @test isapprox(a_final, expected_a, rtol=1e-3)
    end



    # バネの運動のテスト
    @testset "Spring motion" begin
        # バネ定数
        k = 1.0
        # バネの力: F = -kx
        F(x, t) = -k * x
        
        tmax = 2π  # 1周期分
        x_0 = 1.0   # 初期位置
        a_0 = 0.0   # 初期速度
        h = 1e-4   # 時間ステップ

        x_final, a_final = timeprop(F, tmax, x_0, a_0, h)
        
        # 理論値: x = x_0 * cos(ωt), ここでω = √k
        # 理論値: v = -x_0 * ω * sin(ωt)
        ω = √k
        expected_x = x_0 * cos(ω * tmax)
        expected_a = -x_0 * ω * sin(ω * tmax)

        # バネの運動は数値誤差が蓄積しやすいため、許容誤差を大きくする
        @test isapprox(x_final, expected_x, atol=1e-2)
        @test isapprox(a_final, expected_a, atol=1e-2)
    end

    # 周期的振動
    @testset "ex motion" begin
        # 角振動数
         ω = 1.0 
        # 周期的な外力
        F(x, t) = cos(ω * t)  
        
        tmax = 2π  # 1周期分
        x_0 = 1.0   # 初期位置
        a_0 = 0.0   # 初期速度
        h = 1e-4   # 時間ステップ

        x_final, a_final = timeprop(F, tmax, x_0, a_0, h)

        # 理論値: x = x_0 -  \cos(ωt)
        # 理論値: v = sin(ωt)
        expected_x = x_0  -  cos(ω * tmax)
        expected_a =  sin(ω * tmax)

        # バネの運動は数値誤差が蓄積しやすいため、許容誤差を大きくする
        @test isapprox(x_final, expected_x, atol=1e-2)
        @test isapprox(a_final, expected_a, atol=1e-2)
    end

end 

nothing # test実行時に標準出力に大量のメッセージが出ないようにするおまじない
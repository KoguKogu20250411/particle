module particle
# using Plots


function timeprop(F::Function, tmax::Float64, x_0::Float64, a_0::Float64, h::Float64)::Tuple{Float64,Float64}


    x::Float64 =x_0
    a::Float64 = a_0
    t::Float64 = 0.00

    # 刻み幅
    numsteps = Int(floor(tmax / h))



    for i in 1:numsteps
        a += h * F(x, t)
        x += h * a
        t += h

    end

    return x,a
end

# Runge-Kutta 4th order method for time propagation
function rk4prop(F::Function, tmax::Float64, x0::Float64, v0::Float64, h::Float64)
    t = 0.0
    x = x0
    v = v0
    numsteps = Int(floor(tmax / h))

    for i in 1:numsteps
        # k1
        dx1 = v
        dv1 = F(x, t)

        # k2
        dx2 = v + 0.5 * h * dv1
        dv2 = F(x + 0.5 * h * dx1, t + 0.5 * h)

        # k3
        dx3 = v + 0.5 * h * dv2
        dv3 = F(x + 0.5 * h * dx2, t + 0.5 * h)

        # k4
        dx4 = v + h * dv3
        dv4 = F(x + h * dx3, t + h)

        # update x, v
        x += h * (dx1 + 2dx2 + 2dx3 + dx4) / 6
        v += h * (dv1 + 2dv2 + 2dv3 + dv4) / 6
        t += h
    end

    return x, v
end


# function timeprop_picture(F::Function, tmax::Float64, x_0::Float64, a_0::Float64, h::Float64)::Tuple{Vector{Float64}, Vector{Float64}}


#     x::Float64 =x_0
#     a::Float64 = a_0
#     t::Float64 = 0.0

#     # pLots
#     numsteps = Int(floor(tmax / h))
#     results = zeros(Float64, numsteps + 1)
#     times = zeros(Float64, numsteps + 1)

#     results[1] = x
#     times[1] = t

#     for i in 1:numsteps
#         a += h * F(x, t)
#         x += h * a
#         t += h
#         results[i+1] = x
#         times[i+1] = t
#     end

#     return times, results
# end


end # module particle
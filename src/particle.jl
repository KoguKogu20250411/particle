module particle
using Plots


function timeprop(F::Function, tmax::Float64, x_0::Float64, a_0::Float64, h::Float64)::Tuple{Float64,Float64}


    x::Float64 =x_0
    a::Float64 = a_0
    t::Float64 = 0.00

    # pLots
    numsteps = Int(floor(tmax / h))



    for i in 1:numsteps
        a += h * F(x, t)
        x += h * a
        t += h

    end

    return t, x
end


function timeprop_picture(F::Function, tmax::Float64, x_0::Float64, a_0::Float64, h::Float64)::Tuple{Vector{Float64}, Vector{Float64}}


    x::Float64 =x_0
    a::Float64 = a_0
    t::Float64 = 0.0

    # pLots
    numsteps = Int(floor(tmax / h))
    results = zeros(Float64, numsteps + 1)
    times = zeros(Float64, numsteps + 1)

    results[1] = x
    times[1] = t

    for i in 1:numsteps
        a += h * F(x, t)
        x += h * a
        t += h
        results[i+1] = x
        times[i+1] = t
    end

    return times, results
end


end # module particle
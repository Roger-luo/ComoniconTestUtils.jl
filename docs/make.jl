using ComoniconTestUtils
using Documenter

DocMeta.setdocmeta!(ComoniconTestUtils, :DocTestSetup, :(using ComoniconTestUtils); recursive=true)

makedocs(;
    modules=[ComoniconTestUtils],
    authors="Roger-Luo <rogerluo.rl18@gmail.com> and contributors",
    repo="https://github.com/Roger-luo/ComoniconTestUtils.jl/blob/{commit}{path}#{line}",
    sitename="ComoniconTestUtils.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://Roger-luo.github.io/ComoniconTestUtils.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/Roger-luo/ComoniconTestUtils.jl",
)

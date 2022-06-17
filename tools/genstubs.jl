
CROSS_TOOL = "riscv32-unknown-elf"
NM = "$(CROSS_TOOL)-nm"

usage_msg = "usage: julia genstubs.jl bios-elf-path [output-file-name]"

length(ARGS) > 0 || error(usage_msg)
length(ARGS) > 2 && error(usage_msg)

bioself_file = expanduser(ARGS[1])
if (length(ARGS) == 2)
    output = open(ARGS[2], "w")
else
    output = stdout
end

listcmd = pipeline(`$(NM) -n $(bioself_file)`, `uniq`)

print(output, "\t.file\t\"stubs.s\"\n\t.option\tnopic\n\t.attribute arch, \"rv32i2p0_m2p0\"\n\t.attribute unaligned_access, 0\n\t.attribute stack_align, 16\n\t.text\n\t.section\t.text.startup,\"ax\",@progbits\n\t.align\t 2\n")

seen = Set(["main"])
data_section = false

for l in eachline(listcmd)
    obj = split(l)
    if (length(obj) < 3)
        continue
    end
    sym = join(split(obj[3], "."), "_")
    if (sym in seen)
        continue
    end
    push!(seen, sym)
    adr = parse(UInt32, "0x$(obj[1])")
    objtype = obj[2]
    if (match(r"[Tt]", objtype) != nothing && !startswith(sym, "_"))
        print(output, "\t.globl\t$(sym)\n\t.type\t$(sym), @function\n$(sym):\n\tli\tt0, $(adr)\n\tjr\tt0\n\t.size\t$(sym), .-$(sym)\n")
    elseif (match(r"[BDRbdr]", objtype) != nothing && !startswith(sym, "_"))
        sym = string("_bios_", sym, "_p")
        if (!data_section)
            global data_section = true
            print(output, "\t.section\t.sdata,\"aw\"\n\t.align\t4\n")
        end
        print(output, "\t.globl\t$(sym)\n\t.type\t$(sym), @object\n\t.size\t$(sym), 4\n$(sym):\n\t.long\t$(adr)\n")
    end
end

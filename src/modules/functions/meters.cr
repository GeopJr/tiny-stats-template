module Tiny::Stats
  module Meters
    extend self

    def init
      Non::Blocking.spawn do
        old_in, old_out = 0.0, 0.0
        cpus = Hardware::CPU.new
        loop do
          memory = Hardware::Memory.new
          net = Hardware::Net.new

          MEMORY_USED.text = "#{(memory.used/1024).to_i64} mb"
          MEMORY_AVAILABLE.text = "#{(memory.available/1024).to_i64} mb"
          MEMORY_TOTAL.text = "#{(memory.total/1024).to_i64} mb"

          now_in, now_out = net.in_octets, net.out_octets
          NET_DOWN.text = "#{(now_in - old_in) / 1000} kB/s"
          NET_UP.text = "#{(now_out - old_out) / 1000} kB/s"
          old_in, old_out = now_in, now_out

          CPU_USAGE.text = "#{cpus.usage!.to_i64} %"
          CPU_USED.text = "#{cpus.used}"
          CPU_TOTAL.text = "#{cpus.total}"

          sleep 1.second
        end
      end
    end
  end
end

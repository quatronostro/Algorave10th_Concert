BUF5-------------------------------

use_sched_ahead_time 1

live_loop :ambi1 do
  ##| stop
  p = line(-0.85, 0.85, steps: 2).mirror.tick
  sample "C:/Users/Berke/Music/Samples/buffer5/cyberpunk-cellar_93bpm.wav", pan: p, amp: rrand(0.6, 0.8)
  sleep 7.68
end

live_loop :ambi2 do
  ##| stop
  with_fx :lpf, pre_mix: 0.5 do
    with_fx :reverb, mix: 0.8 do
      sample "C:/Users/Berke/Music/Samples/buffer5/deathly-hallows-pad-melody-detuned_110bpm_E_minor.wav", amp: 0.3
      sleep 17.45
    end
  end
end


BUF2------------------
use_debug false
use_sched_ahead_time 1
use_bpm 115
set(:bpm, current_bpm)


live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end

set_mixer_control! lpf_slide: 30, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

live_loop :noi, sync: :metro do
  stop
  use_bpm get(:bpm)
  use_synth :noise
  with_fx :echo, mix: 0.5 do
    with_fx :reverb, mix: 0.6 do
      s = play 80, atack: 1, decay: 1, sustain: 35, release: 15,
        note_slide: 15, amp: 0.6,
        cutoff: 10, cutoff_slide: 20,
        hpf: 100, hpf_slide: 10
      sleep 10
      control s, note: 120, cutoff: 120, hpf: 10
      sleep 30
      control s, note: 80, cutoff: 10, hpf: 100
      sleep 100
    end
  end
end

live_loop :kick, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.4 do
    with_fx :distortion, mix: 0.3 do
      sample :bd_haus, amp: 2, cutoff: 70, release: 0.5
      sleep 1
    end
  end
end


live_loop :snare, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.7 do
    sample "C:/Users/Berke/Music/Samples/buffer2/frens-snare_A_minor.wav", amp: 2.1, cutoff: 90, release: 0.5, pan: 0.5
    sample "C:/Users/Berke/Music/Samples/buffer2/frens-snare_A_minor.wav", amp: 2.2, cutoff: 90, release: 0.5, pan: -0.5
    sleep 2
  end
end

live_loop :synth_bass02, sync: :metro do
  stop
  use_bpm get(:bpm)
  notes1 = [:e2, :e3]
  a1 = (ring 0, 0.4, 0.9, 0.9)
  a2 = 0.6
  c = line(5, 90, steps: 300).mirror.look
  r = 0.3 if spread(7, 8).rotate(4).look
  tick
  use_synth :fm
  with_fx :flanger do
    play notes1, cutoff: c, amp: a2, release: r
    sleep 0.5
  end
end

live_loop :melo, sync: :metro do
  stop
  use_bpm get(:bpm)
  use_random_seed (2022)
  a = line(0.01, 0.9, steps: 300).mirror.look
  k = line(0, 0.6, steps: 100).mirror.look
  use_synth :rodeo
  notes2 = [:g3, :e3, :gb3, :e3, :g3, :b3, :gb3, :e3].shuffle.look
  tick
  with_fx :reverb, mix: 0.7 do
    with_fx :krush, mix: k do
      play notes2, amp: a, attack: 0.1, release: 0.3, sustain: 0.5, cutoff: 50
      sleep 1
    end
  end
end

with_fx :reverb, room: 0.4 do
  live_loop :arpej, sync: :metro do
    stop
    use_bpm get(:bpm)
    c = line(40, 80, steps: 124).mirror.look
    r = line(0.2, 0.5, steps: 100).mirror.look
    f = line(0.3, 0.8, steps: 50).mirror.look
    use_synth :prophet
    notes = (ring :e3, :g3, :b3, :c4, :b3, :g3,
             :e3, :g3, :b3, :c4, :b3, :g3,
             :e3, :g3, :b3, :c4)
    tick
    with_fx :krush, mix: f do
      play notes.look, attack: 0, release: r, cutoff: c, amp: 0.8
      sleep 0.25
    end
  end
end

live_loop :cho, sync: :metro do
  stop
  use_bpm get(:bpm)
  a2 = 0.6
  tick
  use_synth :supersaw
  with_fx :reverb, mix: 0.6, room: 1 do
    1.times do
      2.times do
        play chord(:e5, '5'), sustain: 12, release: 2, amp: a2, cutoff: 90
        sleep 12
      end
      2.times do
        play chord(:e5, :m), sustain: 12, release: 2, amp: a2, cutoff: 90
        sleep 12
      end
      1.times do
        play chord(:g5, '5'), sustain: 12, release: 2, amp: a2, cutoff: 90
        sleep 12
      end
      1.times do
        play chord(:d5, :madd2), sustain: 12, release: 2, amp: a2, cutoff: 90
        sleep 12
      end
      1.times do
        play chord(:a4, :m6), sustain: 12, release: 2, amp: a2, cutoff: 90
        sleep 12
      end
    end
  end
end

live_loop :synth_bass01, sync: :metro do
  stop
  use_bpm get(:bpm)
  a2 = 0.7
  c2 = 85
  r = 0.4
  tick
  use_synth :fm
  with_fx :reverb, mix: 0.5 do
    with_fx :distortion, mix: 0.4 do
      with_fx :krush, mix: 0.5 do
        1.times do
          64.times do
            sleep 0.25
            bas1 = [:e2, :e3]
            play bas1, cutoff: c2, amp: a2, release: r
            sleep 0.5
          end
          16.times do
            sleep 0.25
            bas2 = [:g2, :g3]
            play bas2, cutoff: c2, amp: a2, release: r
            sleep 0.5
          end
          16.times do
            sleep 0.25
            bas3 = [:d2, :d3]
            play bas3, cutoff: c2, amp: a2, release: r
            sleep 0.5
          end
          16.times do
            sleep 0.25
            bas4 = [:a2, :a3]
            play bas4, cutoff: c2, amp: a2, release: r
            sleep 0.5
          end
        end
      end
    end
  end
end


BUF1-----------------------------------

use_debug false
use_sched_ahead_time 1
use_bpm 115
set(:bpm, current_bpm)


live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end

set_mixer_control! lpf_slide: 10, lpf: 120
set_mixer_control! hpf_slide: 10, hpf: 10

live_loop :snare2, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :echo, mix: 0.9 do
    with_fx :reverb, mix: 0.7 do
      sample "C:/Users/Berke/Music/Samples/buffer1/frens-snare_A_minor.wav", amp: 2, cutoff: 100, release: 0.5, pan: 0.5
      sleep 0.25
      sample "C:/Users/Berke/Music/Samples/buffer1/frens-snare_A_minor.wav", amp: 1, cutoff: 80, release: 0.5, pan: -0.5
      sleep 0.25
      sample "C:/Users/Berke/Music/Samples/buffer1/frens-snare_A_minor.wav", amp: 2, cutoff: 60, release: 0.5, pan: 0
      sleep 12
    end
  end
end


live_loop :noih, sync: :metro do
  stop
  use_bpm get(:bpm)
  use_synth :noise
  with_fx :reverb, mix: 0.6 do
    sleep 1
    play :e5, amp: 0.4, release: 0.5
    sleep 1
  end
end

live_loop :hhhh, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  p = line(1, -1, steps: 70).mirror.look
  sample "C:/Users/Berke/Music/Samples/buffer9/008_hihat02.flac", amp: 2, pan: p
  sleep 0.25
end

live_loop :hihat3, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.5 do
    sleep 0.5
    sample "C:/Users/Berke/Music/Samples/buffer1/808ho.1.flac", amp: 1, cutoff: 95, pan: 0.8
    sample "C:/Users/Berke/Music/Samples/buffer1/808ho.1.flac", amp: 1, cutoff: 95, pan: -0.8
    sleep 0.5
  end
end

with_fx :eq, low: -1 do
  live_loop :mi, sync: :metro do
    ##| stop
    use_bpm get(:bpm)
    use_synth :dark_ambience
    p = line(0.7, -0.7, steps: 10).mirror.look
    with_fx :reverb, mix: 1, room: 0.6 do
      1.times do
        play chord(:e3, :madd2), attack: 1, sustain: 3, release: 2, amp: 1.8, cutoff: 90, pan: p
        sleep 4
        play chord(:e2, :madd2), attack: 1, sustain: 3, release: 2, amp: 1.5, cutoff: 90, pan: p
        sleep 4
      end
    end
  end
end


BUF0------------------------------

use_debug false
use_sched_ahead_time 1
use_bpm 128
set(:bpm, current_bpm)

live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end

set_mixer_control! lpf_slide: 30, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

live_loop :kick, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :distortion, mix: 0.3 do
    with_fx :reverb, mix: 0.3 do
      sample "C:/Users/Berke/Music/Samples/buffer0/006_et1kick2.flac", amp: 1.6, cutoff: 90, release: 0.2
      ##| sample :bd_haus, amp: 1.6, cutoff: 70
      sleep 1
    end
  end
end

1.times do
use_synth :dpulse
s = play 28, sustain: 25, release: 10, note_slide: 10, amp: 0.6, cutoff: 40, cutoff_slide: 10
sleep 5
control s, note: 64, cutoff: 100
sleep 10
control s, note: 28, cutoff: 60
sleep 10
end

live_loop :bass01, sync: :metro do
  ##| stop
  use_bpm get(:bpm)
  v1 = line(0.1, 0.5, steps: 50).mirror.look
  p = (ring 0.8, -0.8).look
  c = line(70, 100, steps: 150).mirror.look
  c2 = line(70, 05, steps: 250).mirror.look
  r = 0.4
  tick
  use_synth :dpulse
  with_fx :flanger, mix: v1 do
    with_fx :reverb, mix: 0.7 do
      sleep 0.25
      bas1 = [:e1, :e2]
      play bas1, cutoff: c, amp: 0.3, release: r, pan: p
      sleep 0.5
    end
  end
end

with_fx :reverb, room: 0.3 do
  live_loop :bass2, sync: :metro do
    stop
    use_bpm get(:bpm)
    use_synth :fm
    notes2 = (ring :e2, :e3, :b2, :g2, :g2)
    s2 = (ring 0.25, 1.25, 0.5, 0.25, 1.75)
    tick
    with_fx :distortion, mix: 0.2 do
      play notes2.look, amp: 0.9, cutoff: 100, attack: 0, release: 0.25
      sleep s2.look
    end
  end
end


live_loop :hho, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.4 do
    15.times do
      sleep 0.5
      sample "C:/Users/Berke/Music/Samples/buffer0/808.MA.flac", amp: 0.7, cutoff: 120, release: rrand(0.1, 0.4)
      sleep 0.5
    end
    2.times do
      sleep 0.25
      sample "C:/Users/Berke/Music/Samples/buffer0/808.MA.flac", amp: 0.7, cutoff: 120, release: 0.2
      sleep 0.25
    end
  end
end


live_loop :clp, sync: :metro do
  stop
  use_bpm get(:bpm)
  sleep 1
  with_fx :reverb, mix: 0.4 do
    sample "C:/Users/Berke/Music/Samples/buffer0/808.CP.flac", amp: 1, release: 0.5, cutoff: 95
    sleep 1
  end
end

live_loop :nois, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  1.times do
    use_synth :noise
    with_fx :hpf, mix: 0.7 do
      play :e5, amp: 0.5, release: 0.6
      sleep 32
    end
  end
end

live_loop :bass3, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  with_fx :reverb, mix: 0.5 do
    1.times do
      with_fx :compressor, mix: 1 do
        use_synth :tech_saws
        s = play 40, sustain: 20, release: 10, note_slide: 1, amp: 0.6, cutoff: 40, cutoff_slide: 10
        sleep 5
        control s, note: 47, cutoff: 60
        sleep 10
        control s, note: 45
        sleep 20
      end
    end
  end
end

live_loop :hhh, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :hpf, mix: 0.8 do
    sample "C:/Users/Berke/Music/Samples/buffer0/808.CH.flac", amp: 0.6, release: 0.1, cutoff: 110
    sleep 0.25
  end
end

live_loop :bass4, sync: :metro do
  stop
  use_bpm get(:bpm)
  use_synth :fm
  tick
  with_fx :distortion, mix: 0.2 do
    1.times do
      play :e3, amp: 0.7, attack: 0.1, sustain: 15, release: 0.4, cutoff: 50
      sleep 16
    end
    1.times do
      play :g3, amp: 0.6, attack: 0.1, sustain: 7, release: 0.4, cutoff: 40
      sleep 8
    end
    1.times do
      play :d3, amp: 0.7, attack: 0.1, sustain: 7, release: 0.4, cutoff: 50
      sleep 8
    end
  end
end

live_loop :arpej2, sync: :metro do
  stop
  use_bpm get(:bpm)
  c = line(40, 100, steps: 264).mirror.look
  re = line(0.3, 0.8, steps: 50).mirror.look
  use_synth :supersaw
  s = (ring 0.25, 0.25, 0.25, 1)
  notes = (ring :e3, :g3, :a3, :b4,)
  tick
  with_fx :reverb, mix: re do
    play notes.look, attack: 0.01, release: 0.2, cutoff: c, amp: 0.5
    sleep s.look
  end
end

live_loop :solo, sync: :metro do
  stop
  use_bpm get(:bpm)
  use_synth :kalimba
  tick
  play chord(:e4, '7sus2').choose, amp: 1.3, rate: 1 if spread(12, 16).look
  sleep rrand(0.25, 1)
end


BUF8------------------------------------

use_debug false
use_bpm 139
set(:bpm, current_bpm)


live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end

set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

live_loop :basrepeat, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  use_synth :saw
  cc = line(70, 120, steps: 100).mirror.look
  notas = (ring :db2, :d2, :db2, :e2, :db2, :f2, :db2, :d2)
  with_fx :reverb, mix: line(0.1, 0.4, steps: 75).mirror.look do
    with_fx :krush, mix: line(0.1, 0.4, steps: 50).mirror.look do
      play notas.look, release: 0.4, amp: 1.6, cutoff: cc, attack: 0
      sleep 0.5
    end
  end
end

live_loop :noi, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.7 do
    sample "C:/Users/Berke/Music/Samples/buffer8/002_torpedo.flac", amp: 1.5, release: 3
    sleep 100
  end
end

live_loop :kik2, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.3 do
    sample :bd_mehackit, amp: 0.4, cutoff: 110
    sample :bd_haus, amp: 2, cutoff: 100
    sleep 1
  end
end

with_fx :eq, low: -2 do
  live_loop :melod, sync: :metro do
    ##| stop
    use_bpm get(:bpm)
    use_synth :dark_ambience
    with_fx :reverb, mix: 0.4 do
      with_fx :gverb do
        play :db5, sustain: 20, amp: 0.1, cutoff: 60, pan: -1
        play :db5, sustain: 20, amp: 0.1, cutoff: 60, pan: 1
        sleep 20
      end
    end
  end
end

with_fx :eq, high: -1, low: -1 do
  live_loop :bass3, sync: :metro do
    stop
    use_bpm get(:bpm)
    tick
    with_fx :reverb, mix: 0.5 do
      1.times do
        use_synth :tech_saws
        s = play 64, atack: 2, sustain: 55, release: 3, note_slide: 1, amp: 0.35, cutoff: 30, cutoff_slide: 10
        sleep 3
        control s, cutoff: 50
        sleep 13
        control s, cutoff: 70
        sleep 16
        control s, note: 65, cutoff: 90
        sleep 11
        control s, note: 61, cutoff: 70
        sleep 7
        control s, cutoff: 40
        sleep 4
        control s, cutoff: 20
        sleep 5
      end
    end
  end
end

with_fx :eq, high: -1 do
  live_loop :hit4, sync: :metro do
    stop
    use_bpm get(:bpm)
    tick
    p = line(-0.5, 0.5, steps: 180).mirror.look
    sample "C:/Users/Berke/Music/Samples/buffer8/ignorehh.flac", amp: 0.8, release: 0.2, pan: p
    sleep 0.25
  end
end

live_loop :cl, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  s = (ring 6.75, 0.5, 4.25, 4.5, 6.75, 0.5, 4.25, 4.5)
  with_fx :reverb, mix: 0.5 do
    sample "C:/Users/Berke/Music/Samples/buffer8/808.CP.flac", amp: 1.8, cutoff: 110
    sleep s.look
  end
end


live_loop :cy, sync: :metro do
  stop
  use_bpm get(:bpm)
  sleep 0.5
  with_fx :reverb, mix: 0.5 do
    sample :drum_cymbal_closed, amp: 1.5, cutoff: 124, pan: 0.25
    sample "C:/Users/Berke/Music/Samples/buffer8/ignorehh.flac", release: 0.3, amp: 1, pan: -0.25
    sleep 0.5
  end
end


##| with_fx :ixi_techno, mix: line(0.1, 0.8, steps: 80).mirror.look do
  ##| with_fx :krush, cutoff: line(90, 30, steps: 100).mirror.look do
    live_loop :bas2, sync: :metro do
      stop
      use_bpm get(:bpm)
      use_synth :dsaw
      tick
      notas = (ring :db3, :db2, :db3, :db2,
               :d3, :db2, :db3, :db2,
               :db3, :db2, :db3, :db2,
               :e3, :db2, :db3, :db2,
               :db3, :db2, :db3, :db2,
               :f3, :db2, :db3, :db2,
               :db3, :db2, :db3, :db2,
               :d3, :db2, :db3, :db2)
      aa = (ring 1.5, 1, 1.5, 1)
      cc = line(30, 120, steps: 300).mirror.look
      play notas.look, release: 0.2, amp: aa.look, cutoff: cc
      sleep 0.25
    end
  ##| end
##| end


live_loop :bas4, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  use_synth :saw
  cc = line(70, 120, steps: 100).mirror.look
  notas = (ring :db2, :d2, :db2, :e2, :db2, :f2, :db2, :d2)
  with_fx :reverb, mix: 0.2 do
    with_fx :krush, mix: 0.3 do
      1.times do
        play notas.look, release: 0.4, amp: 1.5, cutoff: 70
        sleep 1.5
      end
    end
  end
end

live_loop :vois, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :echo, mix: 0.6 do
    sample "C:/Users/Berke/Music/Samples/buffer8/189467__speedenza__poem-darkness-voice.wav", rate: 0.9, amp: 1.5,
      release: 1, cutoff: 110
    sleep 100
  end
end


BUF9-----------------------

use_debug false
use_bpm 140
set(:bpm, current_bpm)


live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end


set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10


live_loop :noi2, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.7 do
    sample "C:/Users/Berke/Music/Samples/buffer8/002_torpedo.flac", amp: 2, release: 3
    sleep 100
  end
end

live_loop :kik, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.3 do
    sample :bd_mehackit, amp: 0.4, cutoff: 110
    sample :bd_haus, amp: 2, cutoff: 100
    sleep 1
  end
end


live_loop :hhhh, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  p = line(1, -1, steps: 70).mirror.look
  sample "C:/Users/Berke/Music/Samples/buffer9/008_hihat02.flac", amp: 2, pan: p
  sleep 0.25
end

live_loop :snare, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  sleep 1
  with_fx :reverb do
    sample "C:/Users/Berke/Music/Samples/buffer9/010_sidsnares.flac", amp: 2
    sleep 1
  end
end

live_loop :cy, sync: :metro do
  stop
  use_bpm get(:bpm)
  sleep 0.5
  with_fx :reverb, mix: 0.5 do
    sample :drum_cymbal_closed, amp: 1.2, cutoff: 124, pan: 0.25
    sleep 0.5
  end
end

live_loop :perc1, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  ss = (ring 0.25, 0.25, 0.5, 0.25, 0.25, 0.5, 0.25, 0.25, 0.75, 0.5, 0.25)
  sample "C:/Users/Berke/Music/Samples/buffer9/ignorehh.flac", release: 0.3, amp: 0.8
  sleep ss.look
end

live_loop :ride, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  sample "C:/Users/Berke/Music/Samples/buffer9/004_DXRide.flac", amp: 1.4, cutoff: 110
  sleep 1
end

with_fx :reverb, mix: 0.4 do
  live_loop :basskey, sync: :metro do
    stop
    use_bpm get(:bpm)
    c1 = line(100, 120, steps: 20).mirror.look
    ii = line(0.1, 1, steps: 10).mirror.look
    with_fx :ixi_techno, mix: ii do
      sample "C:/Users/Berke/Music/Samples/buffer9/squarebass.wav", amp: 3, cutoff: c1, pitch: 0.95
      sleep 4
    end
  end
end

with_fx :eq, low: -2 do
  live_loop :fx, sync: :metro do
    stop
    use_bpm get(:bpm)
    use_random_seed (1993)
    with_fx :reverb, mix: 0.4 do
      with_fx :echo, phase: 8 do
        sample "C:/Users/Berke/Music/Samples/buffer9/fx.wav", amp: 1, pitch: 0.6, rate: rrand(0.2, 1)
        sleep rrand(6, 16)
      end
    end
  end
end

with_fx :reverb, mix: 0.5 do
  with_fx :echo, phase: 2, mix: 0.3, max_phase: 1 do
    live_loop :lead, sync: :metro do
      stop
      use_bpm get(:bpm)
      tick
      cc = line(30, 100, steps: 10).mirror.look
      sample "C:/Users/Berke/Music/Samples/buffer9/48488__flick3r__phat.wav", amp: 1.5, rate: 1.33,
        cutoff: cc
      sleep 16
    end
  end
end

live_loop :newbeat, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  sample "C:/Users/Berke/Music/Samples/buffer9/107053__mikobuntu__3.wav"
  sleep 12
end

with_fx :reverb, room: 0.8 do
  live_loop :fa, sync: :metro do
    ##| stop
    use_bpm get(:bpm)
    c = line(50, 100, steps: 8).tick
    use_synth :tech_saws
    play :f2, sustain: 4, amp: 0.8, release: 1, cutoff: c, attack: 0
    sleep 8
  end
end






BUF6------------------------------------------

use_debug false
use_sched_ahead_time 1
use_bpm 143
set(:bpm, current_bpm)

live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end

set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

master = (ramp *range(0, 1, 0.01))
bass_volume = 1
beep_volume = 1

live_loop :kik57, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.2 do
    sample :bd_mehackit, amp: 0.4, cutoff: 90
    sample :bd_haus, amp: 2, cutoff: 90
    sleep 1
  end
end


live_loop :noi2, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.7 do
    with_fx :panslicer, phase: 1 do
      sample "C:/Users/Berke/Music/Samples/buffer8/002_torpedo.flac", amp: rrand(0.8, 1.5), release: 3
      sleep 40
    end
  end
end

with_fx :eq, low: 2, mid: 1 do
  live_loop :drums1, sync: :metro do
    stop
    use_bpm get(:bpm)
    tick
    with_fx :reverb, mix: 0.6 do
      sample :loop_safari, amp: 1, cutoff: 95, rate: 1.19, pitch: rrand(0.3, 0.8)
      sleep 16
    end
  end
end

live_loop :snare, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  sleep 0.5
  with_fx :reverb, mix: 0.5 do
    sample :drum_snare_soft, amp: 0.5, cutoff: 90, release: 0.1, hpf: 70
    sleep 0.5
  end
end

live_loop :hhh, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :hpf, mix: 0.5 do
    sample :drum_cymbal_closed, amp: 1, release: 0, cutoff: 95
    sleep 0.25
  end
end

with_fx :eq, low: -2 do
  with_fx :reverb, mix: 0.5 do
    live_loop :beeps2, sync: :metro do
      stop
      use_bpm get(:bpm)
      tick
      use_synth :bnoise
      cc = line(30, 120, steps: 250).mirror.look
      notas = [:d3, :d4, :d3, :b3, :d2, :d3]
      slps = (ring 0.25, 1, 0.25, 0.75, 1, 0.25)
      play notas.shuffle.tick, release: 0.2, amp: 1, attack: 0.1, cutoff: cc
      sleep slps.look
    end
  end
end


bassline_rhythm = (ring 1, 0, 0, 0, 1, 0, 0, 0,
                   1, 0, 0.5, 0, 1, 0, 0.5, 0)
bassline_notes = (stretch [:d2] * 12 + [:f2, :f2, :a2, :e2], 8)
live_loop :bassline, sync: :metro do
  stop
  use_bpm get(:bpm)
  use_synth :saw
  with_fx :reverb, mix: line(0.15, 0.7, steps: 180).mirror.look do
    with_fx :ixi_techno, mix: line(0, 0.5, steps: 250).mirror.look, cutoff_max: 0.3 do
      play bassline_notes.look,
        amp: master.look * bassline_rhythm.tick * bass_volume,
        attack: 0.03, divisor: line(0, 1, steps: 10).mirror.look,
        depth: rrand(2, 2.5),
        cutoff: line(60, 110, steps: 350).mirror.look,
        res: line(0, 0.4, steps: 520).mirror.look
      sleep 0.25
    end
  end
end


beep_notes = (ring :d3, :d3, :f3, :e3, :d4, :g3)
live_loop :beeps, sync: :metro do
  stop
  use_bpm get(:bpm)
  sleep 0.5
  use_synth :supersaw
  with_fx :reverb, room: line(0.1, 0.5, steps: 100).mirror.look, mix: 0.4 do
    play beep_notes.tick, amp: beep_volume * master.look,
      decay: 0.2, release: 0.1,
      depth: line(0.5, 1.5, steps: 50).mirror.look,
      res: line(0, 0.2, steps: 520).mirror.look,
      cutoff: line(40, 110, steps: 250).mirror.look,
      pan: line(-0.8, 0.8, steps: 100).mirror.look
    sleep 0.25
  end
end


hats_volume = 0.8
open_hats_volume = 1

live_loop :hats, sync: :metro do
  stop
  use_bpm get(:bpm)
  if (spread 3, 8).tick then
    with_fx :rhpf, cutoff: 125, res: 0.8 do
      with_synth :pnoise do
        play :d1, amp: hats_volume * master.tick,
          attack: 0.05, decay: 0.08, release: 0.1
      end
    end
  end
  sleep 0.25
end

live_loop :noise_hats, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :slicer, mix: 1, phase: 0.25, pulse_width: 0.1 do
    with_fx :hpf, cutoff: 130 do
      with_synth :noise do
        play :d1, decay: 1, amp: master.tick * hats_volume
      end
    end
  end
  sleep 1
end

live_loop :open_hats, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :reverb, mix: 0.4, room: 0.8 do
    sleep 0.5
    sample :drum_cymbal_open, start: 0.2, finish: 0.3, amp: master.tick * hats_volume
    sleep 0.5
  end
end


BUF7------------------------------------

use_debug false
use_sched_ahead_time 1
use_bpm 143
set(:bpm, current_bpm)


live_loop :metro do
  use_bpm get(:bpm)
  sleep 1
end

set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

live_loop :kikvari, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  slp = (ring 1, 1, 1, 1, 1, 1, 1, 0.5, 0.5)
  with_fx :reverb, mix: 0.2 do
    sample :bd_sone, amp: 1.5, cutoff: 90
    sleep slp.look
  end
end

synth_mix = 0.7

pong_melody = [[:d3, 0.25],
               [:d3, 0.75],
               [:c4, 0.75],
               [:d3, 1.75]]
live_loop :pong, sync: :metro do
  stop
  use_bpm get(:bpm)
  sleep 4
  with_fx :lpf, cutoff: line(50, 100, steps: 123).mirror.look do
    with_fx :reverb, mix: 0.4 do
      with_fx :bitcrusher, bits: 4, amp: 0.8 * synth_mix do
        pong_melody.each do |n, s|
          synth :beep, note: n, decay: 0.1, release: 0.1, pan: rrand(-0.5, 0.5)
          sleep s
        end
      end
    end
  end
end

with_fx :eq, low: -1 do
  live_loop :arpej2, sync: :metro do
    stop
    use_bpm get(:bpm)
    re = line(0.3, 0.8, steps: 50).mirror.look
    use_synth :sine
    s = (ring 0.25, 0.25, 0.25, 1)
    notes = (ring :d4, :d4, :c5, :d5,)
    tick
    with_fx :reverb, mix: re do
      play notes.look, attack: 0.01, release: 0.2, cutoff: line(40, 110, steps: 264).mirror.look, amp: 0.7
      sleep s.look
    end
  end
end

with_fx :eq, high: -2 do
  live_loop :hit4, sync: :metro do
    stop
    use_bpm get(:bpm)
    tick
    p = line(-0.5, 0.5, steps: 180).mirror.look
    sample "C:/Users/Berke/Music/Samples/buffer8/ignorehh.flac", amp: 0.9, release: 0.2, pan: p
    sleep 0.25
  end
end

live_loop :cy, sync: :metro do
  stop
  use_bpm get(:bpm)
  sleep 0.5
  with_fx :reverb, mix: 0.5 do
    sample :drum_cymbal_closed, amp: 1.5, cutoff: 124, pan: 0.25
    sample "C:/Users/Berke/Music/Samples/buffer8/ignorehh.flac", release: 0.3, amp: 1, pan: -0.25
    sleep 0.5
  end
end

with_fx :eq, low: -1 do
  live_loop :newbass, sync: :metro do
    stop
    use_bpm get(:bpm)
    tick
    with_fx :ixi_techno, phase: 8, cutoff_min: 20, cutoff_max: 100, phase_offset: 0.1 do
      in_thread do
        s = :bd_haus
        sample s
        sleep 0.25*3
        sample s
        sleep 0.25*2
        sample s
        sleep 0.25*3
        sample s
        sleep 0.25*2
        sample s
        sleep 0.25*2
      end
      sleep 4
    end
  end
end

live_loop :blip, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  g = line(0.1, 0.9, steps: 10).look
  r = line(0.01, 0.4, steps: 10).look
  s1 = (ring 0.75, 0.75, 0.75, 0.5)
  s2 = (ring 1, 1, 1, 1)
  with_fx :reverb, mix: g do
    density 1 do
      sample :elec_blip2, pitch: 6, attack: 0, release: r, cutoff: 100
      sleep 0.666
      sample :elec_blip, attack: 0, release: r, cutoff: 100
      sleep 1.333
    end
  end
end

live_loop :wowz, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  with_fx :reverb do
    with_fx :flanger, mix: 0.7 do
      sample :ambi_soft_buzz, cutoff: 100, rate: 1.15
      sleep 16
    end
  end
end


live_loop :beatt2, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  sl = (ring 1, 2.5, 0.5)
  aa = line(0.1, 0.4, steps: 30).mirror.look
  cc = line(80, 50, steps: 65).mirror.look
  with_fx :bitcrusher, mix: 0.3 do
    sample :tabla_ghe6, amp: aa, cutoff: cc
    sleep sl.look
  end
end

live_loop :michael, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  r = line(0.1, 0.7, steps: 180).mirror.look
  a = line(0.01, 0.5, steps: 270).mirror.look
  use_synth :pluck
  with_fx :lpf, cutoff: 90 do
    with_fx :tanh, mix: 0.3 do
      with_fx :rhpf, mix: r do
        play choose( [ :fs1, :fs3 ] ) ,attack: 0.2 ,delay: 4 ,sustain: 0.5, amp: a
        sleep 0.5
      end
    end
  end
end


live_loop :solbemol, sync: :metro do
  stop
  use_bpm get(:bpm)
  tick
  sl = (ring 1, 2.5, 0.5)
  aa = line(0.4, 3, steps: 30).mirror.look
  ##| cc = line(100, 50, steps: 65).mirror.look
  with_fx :flanger do
    with_fx :hpf, cutoff: 60 do
      sample :tabla_ghe6, amp: aa
      sleep sl.look
    end
  end
end

with_fx :eq, high: -1, mid: -1 do
  live_loop :gliii, sync: :metro do
    stop
    use_bpm get(:bpm)
    tick
    cc = line(60, 100, steps: 100).mirror.look
    ss = (ring 0.5, 0.5, 1.25, 1.5, 0.5, 0.25)
    with_fx :gverb, mix: 0.3 do
      sample :glitch_perc5, cutoff: cc, amp: 0.8
      sleep ss.look
    end
  end
end

with_fx :eq, low: -2 do
  with_fx :echo, mix: 0.5 do
    live_loop :drums3, sync: :metro do
      stop
      use_bpm get(:bpm)
      tick
      cc = line(60, 100, steps: 20).mirror.look
      sample :loop_mika, cutoff: cc, rate: 1.17, amp: 0.7, pitch: 0.5
      sleep 16
    end
  end
end

live_loop :mehackit, sync: :metro do
  stop
  use_bpm get(:bpm)
  with_fx :bitcrusher, bits: 4 do
    with_fx :distortion, distort: 0.1 do
      with_fx :hpf, cutoff: 30 do
        s = (['mehackit_phone1', 'mehackit_phone2', 'mehackit_phone3', 'mehackit_phone4']).choose
        if one_in(1)
          sample s, amp: 0.1, beat_stretch: 2, rate: [-4, -2, -1, -0.5, 0.5, 0.6, 0.7, 2, 4].choose
        end
        sleep 4
      end
    end
  end
end



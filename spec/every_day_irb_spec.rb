require_relative '../lib/every_day_irb'

require 'rspec'

describe EveryDayIrb do
  let(:filename){ __FILE__ }
  let(:filename_without_rb){ filename.sub(/\.rb$/, '') }
  let(:path){ File.dirname(filename) + '/..' }

  describe '#ls' do
    it 'returns an array' do
      expect( ls ).to be_a Array
    end

    context '[no args]' do
      it 'calls Dir["./*"] to get the list of all files in the current dir' do
        res = Dir['./*']
        expect( Dir ).to receive(:[]).with('./*').and_return(res)

        ls
      end
    end

    context 'one arg' do
      it 'calls Dir["#{path}/*"] to get the list of all files of the given path' do
        res = Dir["#{path}/*"]
        Dir.should_receive(:[]).with("#{path}/*").and_return(res)

        ls(path)
      end
    end
  end

  describe '#cat' do
    it 'returns a String' do
      expect( cat(filename) ).to be_a String
    end

    it 'calls File.read(path)' do
      expect( File ).to receive(:read).with(filename)

      cat(filename)
    end
  end

  describe '#rq' do
    it 'calls require with the arg' do
      expect( self ).to receive(:require).with('rbconfig')

      rq 'rbconfig'
    end

    it 'calls to_s on the arg' do
      expect( self ).to receive(:require).with('rbconfig')

      rq:rbconfig
    end
  end

  describe '#ld' do
    it 'calls load with the arg, but appends ".rb"' do
      expect( self ).to receive(:load).with(filename)

      ld filename_without_rb
    end

    it 'calls to_s on the arg' do
      expect( self ).to receive(:load).with(filename)

      ld filename_without_rb.to_sym
    end
  end

  describe '#rerequire' do
    it 'requires a library a second time' do
      first_time = require 'abbrev'
      second_time = rerequire 'abbrev'

      expect( second_time ).to be true
    end
  end

  describe '#clear' do
    it "calls the system's clear command" do
      expect( self ).to receive(:system).with('clear')

      clear
    end
  end

  describe '#reset!' do
    pending
  end

  describe '#session_history' do
    pending
  end
end

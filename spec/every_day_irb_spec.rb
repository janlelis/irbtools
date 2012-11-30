require_relative 'spec_helper'
require_relative '../lib/every_day_irb'
require 'rspec'

describe EveryDayIrb do
  let(:a_filename){ __FILE__ }
  let(:a_path){ File.dirname(__FILE__) + '/..' }

  describe '#ls' do
    it 'returns an array' do
      ls.should be_a(Array)
    end

    context 'no args' do
      it 'calls Dir["./*"] to get the list of all files in the current dir' do
        res = Dir['./*']
        Dir.should_receive(:[]).with('./*').and_return(res)
        ls
      end
    end

    context 'one arg' do
      it 'calls Dir["#{a_path}/*"] to get the list of all files of the given a_path' do
        res = Dir["#{a_path}/*"]
        Dir.should_receive(:[]).with("#{a_path}/*").and_return(res)
        ls(a_path)
      end
    end
  end

  describe '#cat' do
    it 'returns a String' do
      cat(a_filename).should be_a String
    end

    it 'calls File.read(a_path)' do
      File.should_receive(:read).with(a_filename)
      cat(a_filename)
    end
  end

  describe '#rq' do
    it 'calls require with the arg' do
      should_receive(:require).with('rbconfig')
      rq 'rbconfig'
    end

    it 'calls to_s on the arg' do
      should_receive(:require).with('rbconfig')
      rq:rbconfig
    end
  end

  describe '#ld' do
    it 'calls load with the arg, but appends ".rb"' do
      should_receive(:load).with(a_filename)
      ld a_filename.sub(/\.rb$/, '')
    end

    it 'calls to_s on the arg' do
      should_receive(:load).with(a_filename)
      ld a_filename.sub(/\.rb$/, '').to_sym
    end
  end

  describe '#rerequire' do
    pending
  end

  describe '#reset!' do
    pending
  end

  describe '#clear' do
    it "calls the system's clear command" do
      should_receive(:system).with('clear')
      clear
    end
  end

  describe '#session_history' do
    pending
  end

end
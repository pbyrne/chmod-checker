require "spec_helper"

describe ChmodParser do
  let(:mode) { "0644" }

  subject { ChmodParser.new(mode) }

  context ".new" do
    it "captures the given mode" do
      expect(subject.mode).to eq(mode)
    end
  end

  context ".chmod" do
    it "returns a Chmod instance" do
      expect(subject.chmod).to be_a(Chmod)
    end

    it "raises an exception when mode is missing" do
      expect { ChmodParser.new("").chmod }.to raise_error(ChmodParser::MissingMode)
      expect { ChmodParser.new(nil).chmod }.to raise_error(ChmodParser::MissingMode)
    end

    it "raises an exception when mode is invalid" do
      expect { ChmodParser.new("asdf").chmod }.to raise_error(ChmodParser::InvalidMode)
    end
  end

  context "#valid?" do
    it "is true for three digits up to 7" do
      expect(ChmodParser.new("644")).to be_valid
      expect(ChmodParser.new("000")).to be_valid
      expect(ChmodParser.new("777")).to be_valid

      expect(ChmodParser.new("888")).to_not be_valid
    end

    it "is true for a three digits up to 7 prefixed by 0, 1, 2, or 4" do
      expect(ChmodParser.new("0644")).to be_valid
      expect(ChmodParser.new("1644")).to be_valid
      expect(ChmodParser.new("2644")).to be_valid
      expect(ChmodParser.new("4644")).to be_valid

      expect(ChmodParser.new("3644")).to_not be_valid
      expect(ChmodParser.new("0888")).to_not be_valid
    end

    it "is false for an invalid mode" do
      expect(ChmodParser.new("asdf")).to_not be_valid
    end

    it "accepts sumbolic modes also"
  end
end

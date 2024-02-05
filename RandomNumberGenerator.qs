namespace Sample {
    open Microsoft.Quantum.Math;
    open Microsoft.Quantum.Convert;
    open Microsoft.Quantum.Intrinsic;

    @EntryPoint()
    operation main() : Int {
        let min = 50;
        let max = 100;
        Message($"Random number with max limit of {max}");
        return GenerateRandomNumber(min, max);
    }

    operation GenerateRandomBit() : Result {
        use q = Qubit();
        H(q);
        let res = M(q);

        Reset(q);
        return res;
    }

    operation GenerateRandomNumber(min : Int, max : Int) : Int {
        mutable bits = [];
        let maxBits = BitSizeI(max);

        for i in 1..maxBits {
            set bits += [GenerateRandomBit()];
        }

        let re = ResultArrayAsInt(bits);

        return ((re > min) and (re < max)) ? re | GenerateRandomNumber(min, max);
    }
}

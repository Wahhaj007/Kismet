function playDiceSound()
    [audio, fs] = audioread('diceRollSoundFx.wav');
    sound(audio,fs);
end
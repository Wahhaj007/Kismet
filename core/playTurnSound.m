function playTurnSound()
    [audio, fs] = audioread('yourTurn.wav');
    sound(audio,fs);
end
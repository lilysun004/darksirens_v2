lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.57153153153153 --fixed-mass2 78.09177177177177 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1002381414.6807508 \
--gps-end-time 1002388614.6807508 \
--d-distr volume \
--min-distance 1466.6455480051602e3 --max-distance 1466.6655480051602e3 \
--l-distr fixed --longitude 142.589111328125 --latitude 38.9849739074707 --i-distr uniform \
--f-lower 20 --disable-spin \
--waveform SEOBNRv4_ROM

bayestar-sample-model-psd \
-o psd.xml \
--H1=aLIGOZeroDetHighPower \
--L1=aLIGOZeroDetHighPower \
--V1=AdvVirgo

bayestar-realize-coincs \
-o coinc.xml \
inj.xml --reference-psd psd.xml \
--detector H1 L1 V1 \
--measurement-error gaussian-noise \
--snr-threshold 4.0 \
--net-snr-threshold 12.0 \
--min-triggers 2 \
--keep-subthreshold

bayestar-localize-coincs coinc.xml

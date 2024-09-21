lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 67.41817817817818 --fixed-mass2 83.72272272272272 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017208817.6886226 \
--gps-end-time 1017216017.6886226 \
--d-distr volume \
--min-distance 4209.357408995091e3 --max-distance 4209.377408995091e3 \
--l-distr fixed --longitude -11.2967529296875 --latitude 20.649887084960938 --i-distr uniform \
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

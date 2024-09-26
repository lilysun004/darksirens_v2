lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 45.56672672672673 --fixed-mass2 83.47059059059059 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1004669769.7063217 \
--gps-end-time 1004676969.7063217 \
--d-distr volume \
--min-distance 3233.4469320489306e3 --max-distance 3233.466932048931e3 \
--l-distr fixed --longitude -157.4074249267578 --latitude -47.135154724121094 --i-distr uniform \
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

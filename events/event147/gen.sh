lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.4802002002002 --fixed-mass2 56.660540540540545 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1021546455.2247705 \
--gps-end-time 1021553655.2247705 \
--d-distr volume \
--min-distance 1697.8644269474737e3 --max-distance 1697.8844269474737e3 \
--l-distr fixed --longitude -156.39627075195312 --latitude 60.547645568847656 --i-distr uniform \
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

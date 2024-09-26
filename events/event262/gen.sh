lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 25.05997997997998 --fixed-mass2 64.22450450450451 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1008917502.0705466 \
--gps-end-time 1008924702.0705466 \
--d-distr volume \
--min-distance 2101.410232391946e3 --max-distance 2101.4302323919464e3 \
--l-distr fixed --longitude 58.87594223022461 --latitude 11.864577293395996 --i-distr uniform \
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

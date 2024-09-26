lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 52.96260260260261 --fixed-mass2 71.87251251251251 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022876273.9618164 \
--gps-end-time 1022883473.9618164 \
--d-distr volume \
--min-distance 4264.297205776834e3 --max-distance 4264.317205776834e3 \
--l-distr fixed --longitude -24.10235595703125 --latitude -68.57471466064453 --i-distr uniform \
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

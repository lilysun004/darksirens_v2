lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 13.293813813813813 --fixed-mass2 57.41693693693694 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013232606.7381301 \
--gps-end-time 1013239806.7381301 \
--d-distr volume \
--min-distance 1861.9140324291247e3 --max-distance 1861.9340324291247e3 \
--l-distr fixed --longitude -157.46328735351562 --latitude -73.5405044555664 --i-distr uniform \
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

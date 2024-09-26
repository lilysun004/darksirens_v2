lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 16.48748748748749 --fixed-mass2 68.09053053053053 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1020082147.063146 \
--gps-end-time 1020089347.063146 \
--d-distr volume \
--min-distance 2572.4543591999713e3 --max-distance 2572.474359199972e3 \
--l-distr fixed --longitude 134.4544219970703 --latitude -22.04233741760254 --i-distr uniform \
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

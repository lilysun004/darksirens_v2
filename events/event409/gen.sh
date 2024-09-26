lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 43.213493493493495 --fixed-mass2 29.094094094094093 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1026694923.492837 \
--gps-end-time 1026702123.492837 \
--d-distr volume \
--min-distance 1297.523986216191e3 --max-distance 1297.543986216191e3 \
--l-distr fixed --longitude 173.88467407226562 --latitude -12.757328987121582 --i-distr uniform \
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

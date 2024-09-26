lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 7.242642642642643 --fixed-mass2 60.10634634634635 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1013893377.8627299 \
--gps-end-time 1013900577.8627299 \
--d-distr volume \
--min-distance 965.6127170013523e3 --max-distance 965.6327170013523e3 \
--l-distr fixed --longitude -4.989471435546875 --latitude -6.942965507507324 --i-distr uniform \
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

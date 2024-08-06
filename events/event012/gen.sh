lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 26.236596596596595 --fixed-mass2 85.82382382382383 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1007031307.3072608 \
--gps-end-time 1007038507.3072608 \
--d-distr volume \
--min-distance 2252.089024062513e3 --max-distance 2252.1090240625135e3 \
--l-distr fixed --longitude -145.362548828125 --latitude -47.9322509765625 --i-distr uniform \
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

lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 23.715275275275275 --fixed-mass2 63.55215215215215 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1017366987.2235452 \
--gps-end-time 1017374187.2235452 \
--d-distr volume \
--min-distance 1951.646111771835e3 --max-distance 1951.666111771835e3 \
--l-distr fixed --longitude 28.343292236328125 --latitude -62.89320373535156 --i-distr uniform \
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

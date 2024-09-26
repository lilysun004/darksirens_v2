lalapps_inspinj \
-o inj.xml \
--m-distr fixMasses --fixed-mass1 21.78226226226226 --fixed-mass2 84.0588988988989 \
--t-distr uniform --time-step 7200 \
--gps-start-time 1022463553.9789009 \
--gps-end-time 1022470753.9789009 \
--d-distr volume \
--min-distance 1411.0160361731355e3 --max-distance 1411.0360361731355e3 \
--l-distr fixed --longitude 168.42166137695312 --latitude 41.76799774169922 --i-distr uniform \
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
